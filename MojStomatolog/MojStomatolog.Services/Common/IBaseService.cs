namespace MojStomatolog.Services.Common
{
    /// <summary>
    /// Interface for a base service providing common CRUD operations and search functionality.
    /// </summary>
    /// <typeparam name="T">The type of the entity DTO.</typeparam>
    /// <typeparam name="TSearch">The type used for search operations.</typeparam>
    public interface IBaseService<T, in TSearch> where T : class where TSearch : BaseSearchObject
    {
        /// <summary>
        /// Retrieves a paged result of entities based on search criteria.
        /// </summary>
        /// <param name="search">Optional search criteria.</param>
        /// <returns>A paged result of entities.</returns>
        Task<PagedResult<T>> Get(TSearch? search = null);

        /// <summary>
        /// Retrieves an entity by its unique identifier.
        /// </summary>
        /// <param name="id">The unique identifier of the entity.</param>
        /// <returns>The entity corresponding to the provided ID.</returns>
        Task<T> GetById(int id);
    }
}