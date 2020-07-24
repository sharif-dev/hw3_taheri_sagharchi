class Node {
	var edges = Array<Node?>(repeating: nil, count: 26)
	var end: Bool = false
}

func insert(_ root: Node, _ word: String) {
	let charArray = Array(word)
	let n = charArray.count
	var parent = root
	
	for i in 0..<n{
		let k = Int(charArray[i].asciiValue! - 65)
		if (parent.edges[k] == nil){
		  //  print(k)
			parent.edges[k] = Node()
		}
		
		parent = parent.edges[k]!
	}
	parent.end = true
}

func inRange(_ i: Int, _ j: Int, _ visited: [[Bool]]) -> Bool {
	let M = visited.count
	let N = visited[M-1].count
	if (i < M && j < N && i >= 0 && j >= 0 && !visited[i][j]){
		return true
	}
	return false
}

func search(_ root: Node, _ mat: [[Character]], _ i: Int, _ j: Int, _ visited: inout [[Bool]], _ str: String){
// 	print(str)
// 	print(root.end)
	if (root.end){
		print(str)
	}
	
	if (inRange( i,  j,  visited)){
		visited[i][j] = true
		
		for k in 0..<26{
			
			if (root.edges[k] != nil){
				let ch = Character(Unicode.Scalar(k + 65)!)
				
				if (inRange( i+1,  j+1,  visited) && mat[i+1][j+1] == ch){
				    // print(str + String(ch))
					search( root.edges[k]!,  mat,  i+1,  j+1,  &visited,  str + String(ch))
				}
				if (inRange( i+1,  j-1,  visited) && mat[i+1][j-1] == ch){
				    // print(str + String(ch))
					search( root.edges[k]!,  mat,  i+1,  j-1,  &visited,  str + String(ch))
				}
				if (inRange( i-1,  j+1,  visited) && mat[i-1][j+1] == ch){
				    // print(str + String(ch))
					search( root.edges[k]!,  mat,  i-1,  j+1,  &visited,  str + String(ch))
				}	
				if (inRange( i-1,  j-1,  visited) && mat[i-1][j-1] == ch){
				    // print(str + String(ch))
					search( root.edges[k]!,  mat,  i-1,  j-1,  &visited,  str + String(ch))
				}	
				if (inRange( i+1,  j,  visited) && mat[i+1][j] == ch){
				    // print(str + String(ch))
					search( root.edges[k]!,  mat,  i+1,  j,  &visited,  str + String(ch))
				}	
				if (inRange( i-1,  j,  visited) && mat[i-1][j] == ch){
				    // print(str + String(ch))
					search( root.edges[k]!,  mat,  i-1,  j,  &visited,  str + String(ch))
				}	
				if (inRange( i,  j+1,  visited) && mat[i][j+1] == ch){
				    // print(str + String(ch))
					search( root.edges[k]!,  mat,  i,  j+1,  &visited,  str + String(ch))
				}	
				if (inRange( i,  j-1,  visited) && mat[i][j-1] == ch){
				    // print(str + String(ch))
					search( root.edges[k]!,  mat,  i,  j-1,  &visited,  str + String(ch))
				}
			}
			
		}
		
		visited[i][j] = false
		
	}
}

func searchAll(_ root: Node, _ mat: [[Character]]){
	
	let M = mat.count
	let N = mat[M-1].count
	
	var visited = Array<[Bool]>(repeating: Array<Bool>(repeating: false, count: N), count: M)
	let parent = root
	var str: String = ""
	
	for i in 0..<M{
		for j in 0..<N{
			let k = Int(mat[i][j].asciiValue! - 65)
			if (parent.edges[k] != nil){
				str = str + String(mat[i][j])
				search( parent.edges[k]!,  mat,  i,  j,  &visited,  str)
				str = ""
			}
		}
	}
	
}

let words = readLine()
let wordsArr = words!.split(whereSeparator: {$0 == " "})
var wArr = Array<String>()

for word in wordsArr{
	wArr.append(String(word))
}

let dimensions = readLine()
let dimensionsArr = dimensions!.split(whereSeparator: {$0 == " "})
let M = Int(dimensionsArr[0])!
let N = Int(dimensionsArr[1])!
var Mat = Array<[Character]>()
for _ in 0..<M{
	let chars = readLine()
	let charsArr = chars!.split(whereSeparator: {$0 == " "})
	var cArr = Array<Character>()
	for i in 0..<charsArr.count{
	    let s = Array(charsArr[i])
	    cArr.append(s[0])
	}
	Mat.append(cArr)
}

var root = Node()

for word in wArr{
	insert(root, word)
}

searchAll(root, Mat)