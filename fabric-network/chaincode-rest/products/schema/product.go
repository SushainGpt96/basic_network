package product

// Product describes basic details of what makes up a simple asset
type Product struct {
	Name        string `json:"name"`
	Description string `json:"description"`
	Quantity    int    `json:"quantity"`
	Origin      string `json:"origin"`
	Price       int`json:"price"`
}
