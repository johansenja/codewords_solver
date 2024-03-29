require "codewords_solver"

RSpec.describe CodewordsSolver do
  describe "#solve!" do
    let!(:grid1) {
      [
        [1, 13, 7, 11],
        [22, 5, 5, 13, 10, 17, 4, 15],
        [4, 13, 18, 3, 23],
        [16, 13, 7, 7, 13, 22, 26],
        [15, 10, 4, 12, 24, 25, 7, 17],
        [25, 13, 4, 22],
        [12, 24, 22, 9, 26, 23],
        [5, 13, 12, 26, 10, 17],
        [17, 26, 21, 14],
        [24, 12, 4, 23, 13, 12, 26, 15],
        [19, 4, 22, 8, 17, 10, 23],
        [4, 12, 13, 15, 17],
        [11, 13, 15, 10, 22, 9, 26, 23],
        [2, 9, 13, 19],
        [1, 22, 4, 20, 15, 19, 12, 10, 17],
        [19, 22, 11],
        [7, 12, 18, 17, 4],
        [22, 25, 21, 13, 22, 9, 15],
        [15, 23, 12, 24, 13, 26, 12],
        [7, 17, 18, 22],
        [5, 13, 16, 16, 7, 17],
        [23, 12, 4, 23, 12, 26],
        [13, 11, 7, 17],
        [24, 13, 6, 23, 9, 4, 17],
        [17, 11, 13, 23, 13, 22, 26],
        [12, 11, 13, 17, 9],
        [15, 22, 26],
        [22, 21, 17, 4, 15, 7, 17, 17, 19],
      ]
    }
    let!(:grid2) {
      [
        [18, 26, 16],
        [12, 20, 16, 26, 11],
        [6, 15, 4],
        [24, 15, 10, 7, 22],
        [21, 12, 26, 20, 14, 22, 12],
        [1, 4, 5, 22, 8, 12, 15, 9],
        [12, 19, 6, 12],
        [1, 5, 1, 15, 20],
        [13, 1, 26, 8, 3],
        [26, 4, 15, 20],
        [3, 15, 9, 12, 5, 15, 17, 12],
        [5, 1, 4, 4, 26, 8, 22],
        [14, 9, 15, 6, 12],
        [12, 6, 26],
        [5, 12, 8, 23, 12],
        [22, 26, 24],
        [18, 26, 24, 2, 1, 20],
        [16, 1, 10, 17, 5],
        [12, 25, 22, 12, 8, 3, 15, 20],
        [16, 15, 21, 15, 15, 8],
        [11, 26, 26, 19],
        [6, 8, 14, 3, 19, 12, 8],
        [4, 14, 12, 10, 12, 5],
        [9, 26, 1, 5, 5, 12],
        [5, 7, 15, 9, 4, 26, 26],
        [16, 26, 24, 5],
        [8, 15, 2, 22, 12, 8],
        [18, 1, 23, 12, 3, 14, 20, 12],
        [15, 11, 15, 14, 22],
        [10, 12, 20, 12, 8, 24],
      ]
    }
    let!(:grid3) {
      [
        [15, 17, 17, 20, 22, 17, 18, 18],
        [9, 22, 6, 18],
        [5, 19, 17, 4, 23],
        [25, 4, 12, 5, 7, 9, 6],
        [17, 21, 5, 10],
        [11, 9, 12, 10, 12, 17, 18, 18],
        [12, 17, 17, 11, 17, 12],
        [24, 12, 6, 7, 7, 8],
        [2, 4, 12, 14, 23, 4, 22, 17],
        [4, 24, 6, 17],
        [9, 7, 3, 5, 9, 6, 18],
        [9, 21, 5, 19, 17],
        [20, 17, 12, 7],
        [4, 19, 13, 4, 25, 17, 22, 10],
        [15, 4, 5, 26, 17],
        [12, 9, 2, 23, 9, 25, 20],
        [17, 23, 17, 24, 5, 18, 17],
        [12, 9, 3, 17, 12],
        [22, 6, 23, 23],
        [12, 17, 4, 23, 10, 9, 12],
        [18, 17, 25, 10, 9, 12],
        [6, 22, 6, 18, 17, 19],
        [9, 12, 4, 10, 9, 12, 8],
        [5, 9, 10, 4],
        [22, 9, 7, 23, 17],
        [7, 17, 24, 6, 5, 23, 17],
        [18, 16, 6, 5, 18, 1, 8],
        [17, 21, 17, 12, 10],
      ]
    }

    it "solves a puzzle with common starting letters" do
      subj = described_class.new grid1, { 5 => "F", 7 => "L" }
      subj.solve!
      expect(subj.instance_variable_get(:@letters_by_number)).to eq(
        {
          1 => "W",
          2 => "Q",
          3 => "H",
          4 => "R",
          5 => "F",
          6 => "X",
          7 => "L",
          8 => "J",
          9 => "U",
          10 => "C",
          11 => "D",
          12 => "A",
          13 => "I",
          14 => "Y",
          15 => "S",
          16 => "Z",
          17 => "E",
          18 => "G",
          19 => "P",
          20 => "K",
          21 => "V",
          22 => "O",
          23 => "T",
          24 => "M",
          25 => "B",
          26 => "N",
        }
      )
    end

    it "solves a puzzle with uncommon starting letters" do
      subj = described_class.new grid2, { 21 => "Z", 25 => "X" }
      subj.solve!
      expect(subj.instance_variable_get(:@letters_by_number)).to eq(
        {
          21 => "Z",
          25 => "X",
          12 => "E",
          22 => "T",
          8 => "R",
          3 => "N",
          15 => "A",
          20 => "L",
          2 => "F",
          18 => "J",
          1 => "U",
          23 => "V",
          14 => "I",
          11 => "W",
          10 => "C",
          24 => "Y",
          7 => "H",
          19 => "D",
          6 => "G",
          5 => "S",
          13 => "Q",
          26 => "O",
          4 => "P",
          9 => "M",
          16 => "B",
          17 => "K",
        }
      )
    end

    it "solves a Times codeword" do
      subj = described_class.new grid3, { 6 => "U", 18 => "S" }
      subj.solve!
      expect(subj.instance_variable_get(:@letters_by_number)).to eq(
        {
          1 => "H",
          2 => "W",
          3 => "V",
          4 => "A",
          5 => "I",
          6 => "U",
          7 => "B",
          8 => "Y",
          9 => "O",
          10 => "T",
          11 => "F",
          12 => "R",
          13 => "J",
          14 => "P",
          15 => "M",
          16 => "Q",
          17 => "E",
          18 => "S",
          19 => "D",
          20 => "K",
          21 => "X",
          22 => "N",
          23 => "L",
          24 => "G",
          25 => "C",
          26 => "Z",
        }
      )
    end
  end
end
