#priority 727

/*
    Similar to Percentage<T>, but using int as weight.
    与 Percentaged<T> 类似，但使用 int 作为权重。
*/
public class Weighted<T> {
    public val data as T : get;
    public val weight as int : get;

    public this(data as T, weight as int) {
        this.data = data;
        this.weight = weight;
    }

    public getData() as T => data;
    public getWeight() as int => weight;
}