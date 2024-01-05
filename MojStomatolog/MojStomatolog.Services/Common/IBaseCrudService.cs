namespace MojStomatolog.Services.Common
{
    /// <summary>
    /// Interface for a CRUD service, extending the base service with insert and update operations.
    /// </summary>
    /// <typeparam name="T">The type of the entity DTO.</typeparam>
    /// <typeparam name="TSearch">The type used for search operations.</typeparam>
    /// <typeparam name="TInsert">The type used for insertion.</typeparam>
    /// <typeparam name="TUpdate">The type used for update.</typeparam>
    public interface IBaseCrudService<T, in TSearch, in TInsert, in TUpdate> : IBaseService<T, TSearch>
        where T : class
        where TSearch : class
    {

        /// <summary>
        /// Inserts a new entity into the database.
        /// </summary>
        /// <param name="insert">The data used for insertion.</param>
        /// <returns>The inserted entity.</returns>
        Task<T> Insert(TInsert insert);

        /// <summary>
        /// Updates an existing entity in the database based on its ID.
        /// </summary>
        /// <param name="id">The unique identifier of the entity to be updated.</param>
        /// <param name="update">The data used for updating the entity.</param>
        /// <returns>The updated entity.</returns>
        Task<T> Update(int id, TUpdate update);

        /// <summary>
        /// Deletes an existing entity in the database based on its ID.
        /// </summary>
        /// <param name="id">The unique identifier of the entity to be deleted.</param>
        /// <returns>
        ///   <c>true</c> if the deletion was successful; otherwise, <c>false</c> if the entity with the specified ID was not found.
        /// </returns>
        Task<bool> Delete(int id);
    }
}